import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template sendingIndicatorWrapper}
/// Helper widget for building a [StreamSendingIndicator].
///
/// Used in [BottomRow]. Should not be used elsewhere.
/// {@endtemplate}
class SendingIndicatorWrapper extends StatelessWidget {
  /// {@macro sendingIndicatorWrapper}
  const SendingIndicatorWrapper({
    super.key,
    required this.messageTheme,
    required this.message,
    required this.hasNonUrlAttachments,
    required this.streamChat,
    required this.streamChatTheme,
    this.uploadRemainingIndicatorBuilder, //* INNO NOTE
    this.attachmentsUploadProgressTextStyle, //* INNO NOTE
    this.messageReadBuilder, //* INNO NOTE
    this.sendedAndUnreadWordingWidget, //* INNO NOTE
    this.readedIndicatorBuilder, //* INNO NOTE
    this.sendedIndicatorBuilder, //* INNO NOTE
    this.sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
    this.failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
    this.customConditionSendingIndicatorBuilder, //* INNO NOTE
  });

  final Widget Function(Message message)? uploadRemainingIndicatorBuilder; //* INNO NOTE
  final TextStyle? attachmentsUploadProgressTextStyle; //* INNO NOTE
  final Widget Function(Message message, int memberCount, Iterable<Read> readList, Widget child)?
      messageReadBuilder; //* INNO NOTE
  final Widget Function(Message message, Widget child)? sendedAndUnreadWordingWidget; //* INNO NOTE
  final Widget Function(Message message)? readedIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message)? sendedIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message)? sendingOrUpdatingIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message, Channel? channel)?
      failedOrFailedUpdateIndicatorBuilder; //* INNO NOTE
  final Widget? Function(Message message, Widget child)?
      customConditionSendingIndicatorBuilder; //* INNO NOTE

  /// {@macro messageTheme}
  final StreamMessageThemeData messageTheme;

  /// {@macro message}
  final Message message;

  /// {@macro hasNonUrlAttachments}
  final bool hasNonUrlAttachments;

  /// {@macro streamChat}
  final StreamChatState streamChat;

  /// {@macro streamChatThemeData}
  final StreamChatThemeData streamChatTheme;

  @override
  Widget build(BuildContext context) {
    final style = messageTheme.createdAtStyle;
    final memberCount = StreamChannel.of(context).channel.memberCount ?? 0;

    if (hasNonUrlAttachments &&
        (message.status == MessageSendingStatus.sending ||
            message.status == MessageSendingStatus.updating)) {
      final totalAttachments = message.attachments.length;
      final uploadRemaining = message.attachments.where((it) => !it.uploadState.isSuccess).length;

      if (uploadRemaining == 0) {
        //* INNO NOTE: edit this.
        return uploadRemainingIndicatorBuilder?.call(message) ??
            StreamSvgIcon.check(
              size: style!.fontSize,
              color: IconTheme.of(context).color!.withOpacity(0.5),
            );
      }

      //TODO: recheck this when implement attachments
      return Text(
        context.translations.attachmentsUploadProgressText(
          remaining: uploadRemaining,
          total: totalAttachments,
        ),
        style: attachmentsUploadProgressTextStyle,
      );
    }

    final channel = StreamChannel.of(context).channel;

    return BetterStreamBuilder<List<Read>>(
      stream: channel.state?.readStream,
      initialData: channel.state?.read,
      builder: (context, data) {
        final readList = data.where((it) =>
            it.user.id != streamChat.currentUser?.id &&
            (it.lastRead.isAfter(message.createdAt) ||
                it.lastRead.isAtSameMomentAs(message.createdAt)));
        final isMessageRead = readList.length >= (channel.memberCount ?? 0) - 1;

        //* INNO NOTE: edit this.
        Widget child = StreamSendingIndicator(
          message: message,
          isMessageRead: isMessageRead,
          size: style!.fontSize,
          channel: channel,
          readedIndicatorBuilder: readedIndicatorBuilder,
          sendedIndicatorBuilder: sendedIndicatorBuilder,
          sendingOrUpdatingIndicatorBuilder: sendingOrUpdatingIndicatorBuilder,
          failedOrFailedUpdateIndicatorBuilder: failedOrFailedUpdateIndicatorBuilder,
        );

        //* INNO NOTE: add this.
        if (message.status == MessageSendingStatus.sent &&
            !isMessageRead &&
            sendedAndUnreadWordingWidget?.call(message, child) != null) {
          child = sendedAndUnreadWordingWidget!.call(message, child);
        }

        if (isMessageRead) {
          child = messageReadBuilder?.call(message, memberCount, readList, child) ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (memberCount > 2)
                    Text(
                      readList.length.toString(),
                      style: style.copyWith(
                        color: streamChatTheme.colorTheme.accentPrimary,
                      ),
                    ),
                  const SizedBox(width: 2),
                  child,
                ],
              );
        }

        //* INNO NOTE: add this.
        if (customConditionSendingIndicatorBuilder != null) {
          return customConditionSendingIndicatorBuilder!.call(message, child) ?? child;
        }

        return child;
      },
    );
  }
}
