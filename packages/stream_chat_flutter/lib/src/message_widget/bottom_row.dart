import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/src/message_widget/sending_indicator_wrapper.dart';
import 'package:stream_chat_flutter/src/message_widget/thread_painter.dart';
import 'package:stream_chat_flutter/src/message_widget/thread_participants.dart';
import 'package:stream_chat_flutter/src/message_widget/username.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template bottomRow}
/// The bottom row of a [StreamMessageWidget].
///
/// Used in [MessageWidgetContent]. Should not be used elsewhere.
/// {@endtemplate}
class BottomRow extends StatelessWidget {
  /// {@macro bottomRow}
  const BottomRow({
    super.key,
    required this.isDeleted,
    required this.message,
    required this.showThreadReplyIndicator,
    required this.showInChannel,
    required this.showTimeStamp,
    required this.showUsername,
    required this.reverse,
    required this.showSendingIndicator,
    required this.hasUrlAttachments,
    required this.isGiphy,
    required this.isOnlyEmoji,
    required this.messageTheme,
    required this.streamChatTheme,
    required this.hasNonUrlAttachments,
    required this.streamChat,
    this.deletedBottomRowBuilder,
    this.onThreadTap,
    this.usernameBuilder,
    this.sendingIndicatorBuilder,
    this.timestamp, //* INNO NOTE
    this.username, //* INNO NOTE
    this.attachmentsUploadProgressTextStyle, //* INNO NOTE
    this.uploadRemainingIndicatorBuilder, //* INNO NOTE
    this.messageReadBuilder, //* INNO NOTE
    this.sendedAndUnreadWordingWidget, //* INNO NOTE
    this.readedIndicatorBuilder, //* INNO NOTE
    this.sendedIndicatorBuilder, //* INNO NOTE
    this.sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
    this.failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
    this.customConditionSendingIndicatorBuilder, //* INNO NOTE
  });

  final Widget Function(Message message)? timestamp; //* INNO NOTE
  final Widget Function(Message message)? username; //* INNO NOTE
  final TextStyle? attachmentsUploadProgressTextStyle; //* INNO NOTE
  final Widget Function(Message message)? uploadRemainingIndicatorBuilder; //* INNO NOTE
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

  /// {@macro messageIsDeleted}
  final bool isDeleted;

  /// {@macro deletedBottomRowBuilder}
  final Widget Function(BuildContext, Message)? deletedBottomRowBuilder;

  /// {@macro message}
  final Message message;

  /// {@macro showThreadReplyIndicator}
  final bool showThreadReplyIndicator;

  /// {@macro showInChannelIndicator}
  final bool showInChannel;

  /// {@macro showTimestamp}
  final bool showTimeStamp;

  /// {@macro showUsername}
  final bool showUsername;

  /// {@macro reverse}
  final bool reverse;

  /// {@macro showSendingIndicator}
  final bool showSendingIndicator;

  /// {@macro hasUrlAttachments}
  final bool hasUrlAttachments;

  /// {@macro isGiphy}
  final bool isGiphy;

  /// {@macro isOnlyEmoji}
  final bool isOnlyEmoji;

  /// {@macro hasNonUrlAttachments}
  final bool hasNonUrlAttachments;

  /// {@macro messageTheme}
  final StreamMessageThemeData messageTheme;

  /// {@macro onThreadTap}
  final void Function(Message)? onThreadTap;

  /// {@macro streamChatThemeData}
  final StreamChatThemeData streamChatTheme;

  /// {@macro streamChat}
  final StreamChatState streamChat;

  /// {@macro usernameBuilder}
  final Widget Function(BuildContext, Message)? usernameBuilder;

  /// {@macro sendingIndicatorBuilder}
  final Widget Function(BuildContext, Message)? sendingIndicatorBuilder;

  /// {@template copyWith}
  /// Creates a copy of [BottomRow] with specified attributes
  /// overridden.
  /// {@endtemplate}
  BottomRow copyWith({
    Key? key,
    bool? isDeleted,
    Message? message,
    bool? showThreadReplyIndicator,
    bool? showInChannel,
    bool? showTimeStamp,
    bool? showUsername,
    bool? reverse,
    bool? showSendingIndicator,
    bool? hasUrlAttachments,
    bool? isGiphy,
    bool? isOnlyEmoji,
    StreamMessageThemeData? messageTheme,
    StreamChatThemeData? streamChatTheme,
    bool? hasNonUrlAttachments,
    StreamChatState? streamChat,
    Widget Function(BuildContext, Message)? deletedBottomRowBuilder,
    void Function(Message)? onThreadTap,
    Widget Function(BuildContext, Message)? usernameBuilder,
    Widget Function(BuildContext, Message)? sendingIndicatorBuilder,
    Widget Function(Message message)? timestamp, //* INNO NOTE
    Widget Function(Message message)? username, //* INNO NOTE
    Widget Function(Message message)? uploadRemainingIndicatorBuilder, //* INNO NOTE
    TextStyle? attachmentsUploadProgressTextStyle, //* INNO NOTE
    Widget Function(Message message, int memberCount, Iterable<Read> readList, Widget child)?
        messageReadBuilder, //* INNO NOTE
    Widget Function(Message message, Widget child)? sendedAndUnreadWordingWidget, //* INNO NOTE
    Widget Function(Message message)? readedIndicatorBuilder, //* INNO NOTE
    Widget Function(Message message)? sendedIndicatorBuilder, //* INNO NOTE
    Widget Function(Message message)? sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
    Widget Function(Message message, Channel? channel)?
        failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
    Widget? Function(Message message, Widget child)?
        customConditionSendingIndicatorBuilder, //* INNO NOTE
  }) =>
      BottomRow(
        key: key ?? key,
        isDeleted: isDeleted ?? this.isDeleted,
        message: message ?? this.message,
        showThreadReplyIndicator: showThreadReplyIndicator ?? this.showThreadReplyIndicator,
        showInChannel: showInChannel ?? this.showInChannel,
        showTimeStamp: showTimeStamp ?? this.showTimeStamp,
        showUsername: showUsername ?? this.showUsername,
        reverse: reverse ?? this.reverse,
        showSendingIndicator: showSendingIndicator ?? this.showSendingIndicator,
        hasUrlAttachments: hasUrlAttachments ?? this.hasUrlAttachments,
        isGiphy: isGiphy ?? this.isGiphy,
        isOnlyEmoji: isOnlyEmoji ?? this.isOnlyEmoji,
        messageTheme: messageTheme ?? this.messageTheme,
        streamChatTheme: streamChatTheme ?? this.streamChatTheme,
        hasNonUrlAttachments: hasNonUrlAttachments ?? this.hasNonUrlAttachments,
        streamChat: streamChat ?? this.streamChat,
        deletedBottomRowBuilder: deletedBottomRowBuilder ?? this.deletedBottomRowBuilder,
        onThreadTap: onThreadTap ?? this.onThreadTap,
        usernameBuilder: usernameBuilder ?? this.usernameBuilder,
        sendingIndicatorBuilder: sendingIndicatorBuilder ?? this.sendingIndicatorBuilder,
        timestamp: timestamp ?? this.timestamp, //* INNO NOTE
        username: username ?? this.username, //* INNO NOTE
        attachmentsUploadProgressTextStyle: attachmentsUploadProgressTextStyle ??
            this.attachmentsUploadProgressTextStyle, //* INNO NOTE
        uploadRemainingIndicatorBuilder:
            uploadRemainingIndicatorBuilder ?? this.uploadRemainingIndicatorBuilder, //* INNO NOTE
        messageReadBuilder: messageReadBuilder ?? this.messageReadBuilder, //* INNO NOTE
        sendedAndUnreadWordingWidget:
            sendedAndUnreadWordingWidget ?? this.sendedAndUnreadWordingWidget, //* INNO NOTE
        readedIndicatorBuilder: readedIndicatorBuilder ?? this.readedIndicatorBuilder, //* INNO NOTE
        sendedIndicatorBuilder: sendedIndicatorBuilder ?? this.sendedIndicatorBuilder, //* INNO NOTE
        sendingOrUpdatingIndicatorBuilder: sendingOrUpdatingIndicatorBuilder ??
            this.sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
        failedOrFailedUpdateIndicatorBuilder: failedOrFailedUpdateIndicatorBuilder ??
            this.failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
        customConditionSendingIndicatorBuilder: customConditionSendingIndicatorBuilder ??
            this.customConditionSendingIndicatorBuilder, //* INNO NOTE
      );

  @override
  Widget build(BuildContext context) {
    if (isDeleted) {
      return deletedBottomRowBuilder?.call(
            context,
            message,
          ) ??
          const Offstage();
    }

    final children = <WidgetSpan>[];

    final threadParticipants = message.threadParticipants?.take(2);
    final showThreadParticipants = threadParticipants?.isNotEmpty == true;
    final replyCount = message.replyCount;

    var msg = context.translations.threadReplyLabel;
    if (showThreadReplyIndicator && replyCount! > 1) {
      msg = context.translations.threadReplyCountText(replyCount);
    }

    // ignore: prefer_function_declarations_over_variables
    final _onThreadTap = () async {
      try {
        var message = this.message;
        if (showInChannel) {
          final channel = StreamChannel.of(context);
          message = await channel.getMessage(message.parentId!);
        }
        return onThreadTap!(message);
      } catch (e, stk) {
        debugPrint('$e');
        debugPrint('$stk');
        // ignore: avoid_returning_null_for_void
        return null;
      }
    };

    const usernameKey = Key('username');

    children.addAll([
      if (showSendingIndicator)
        WidgetSpan(
          child: sendingIndicatorBuilder?.call(context, message) ??
              //* INNO NOTE: edit this.
              SendingIndicatorWrapper(
                messageTheme: messageTheme,
                message: message,
                hasNonUrlAttachments: hasNonUrlAttachments,
                streamChat: streamChat,
                streamChatTheme: streamChatTheme,
                uploadRemainingIndicatorBuilder: uploadRemainingIndicatorBuilder, //* INNO NOTE
                attachmentsUploadProgressTextStyle:
                    attachmentsUploadProgressTextStyle, //* INNO NOTE
                messageReadBuilder: messageReadBuilder, //* INNO NOTE
                sendedAndUnreadWordingWidget: sendedAndUnreadWordingWidget, //* INNO NOTE
                readedIndicatorBuilder: readedIndicatorBuilder, //* INNO NOTE
                sendedIndicatorBuilder: sendedIndicatorBuilder, //* INNO NOTE
                sendingOrUpdatingIndicatorBuilder: sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
                failedOrFailedUpdateIndicatorBuilder:
                    failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
                customConditionSendingIndicatorBuilder: customConditionSendingIndicatorBuilder,
              ),
        ),

      if (showTimeStamp && !showUsername)
        //* INNO NOTE : custom message time stamp.
        WidgetSpan(
          child: timestamp?.call(message) ??
              Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: messageTheme.createdAtStyle,
              ),
        ),

      //* INNO NOTE : custom message time stamp.
      if (showUsername)
        WidgetSpan(
          child: Row(
            children: [
              if (showTimeStamp)
                //* INNO NOTE : custom message time stamp.
                timestamp?.call(message) ??
                    Text(
                      Jiffy(message.createdAt.toLocal()).jm,
                      style: messageTheme.createdAtStyle,
                    ),

              //
              Flexible(
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Flexible(
                      child: SizedBox(
                        key: usernameKey,
                        child: usernameBuilder?.call(context, message) ??
                            username?.call(message) ??
                            Username(
                              key: usernameKey,
                              message: message,
                              messageTheme: messageTheme,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Username(
          //   key: usernameKey,
          //   message: message,
          //   messageTheme: messageTheme,
          // ),
        ),
    ]);

    final showThreadTail = !(hasUrlAttachments || isGiphy || isOnlyEmoji) &&
        (showThreadReplyIndicator || showInChannel);

    final threadIndicatorWidgets = <WidgetSpan>[
      if (showThreadTail)
        WidgetSpan(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.textScaleFactor * ((messageTheme.repliesStyle?.fontSize ?? 1) / 2),
            ),
            child: CustomPaint(
              size: const Size(16, 32) * context.textScaleFactor,
              painter: ThreadReplyPainter(
                context: context,
                color: messageTheme.messageBorderColor,
                reverse: reverse,
              ),
            ),
          ),
        ),
      if (showInChannel || showThreadReplyIndicator) ...[
        if (showThreadParticipants)
          WidgetSpan(
            child: SizedBox.fromSize(
              size: Size((threadParticipants!.length * 8.0) + 8, 16),
              child: ThreadParticipants(
                threadParticipants: threadParticipants,
                streamChatTheme: streamChatTheme,
              ),
            ),
          ),
        WidgetSpan(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _onThreadTap,
              child: Text(msg, style: messageTheme.repliesStyle),
            ),
          ),
        ),
      ],
    ];

    if (reverse) {
      children.addAll(threadIndicatorWidgets.reversed);
    } else {
      children.insertAll(0, threadIndicatorWidgets);
    }

    return Text.rich(
      TextSpan(
        children: [
          ...children,
        ],
        // .insertBetween(const WidgetSpan(child: SizedBox(width: 8))),
      ),
      maxLines: 1,
      textAlign: reverse ? TextAlign.right : TextAlign.left,
    );
  }
}
