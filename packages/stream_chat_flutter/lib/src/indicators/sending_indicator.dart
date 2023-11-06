import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamSendingIndicator}
/// Shows the sending status of a message.
/// {@endtemplate}
class StreamSendingIndicator extends StatelessWidget {
  /// {@macro streamSendingIndicator}
  const StreamSendingIndicator({
    super.key,
    required this.message,
    this.isMessageRead = false,
    this.size = 12,
    this.channel, //* INNO NOTE
    this.readedIndicatorBuilder, //* INNO NOTE
    this.sendedIndicatorBuilder, //* INNO NOTE
    this.sendingOrUpdatingIndicatorBuilder, //* INNO NOTE
    this.failedOrFailedUpdateIndicatorBuilder, //* INNO NOTE
  });

  final Channel? channel; //* INNO NOTE
  final Widget Function(Message message)? readedIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message)? sendedIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message)? sendingOrUpdatingIndicatorBuilder; //* INNO NOTE
  final Widget Function(Message message, Channel? channel)?
      failedOrFailedUpdateIndicatorBuilder; //* INNO NOTE

  /// Message for sending indicator
  final Message message;

  /// Flag if message is read
  final bool isMessageRead;

  /// Size for message
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (isMessageRead) {
      //* INNO NOTE: edit this.
      return readedIndicatorBuilder?.call(message) ??
          StreamSvgIcon.checkAll(
            size: size,
            color: StreamChatTheme.of(context).colorTheme.accentPrimary,
          );
    }
    if (message.status == MessageSendingStatus.sent) {
      //* INNO NOTE: edit this.
      return sendedIndicatorBuilder?.call(message) ??
          StreamSvgIcon.check(
            size: size,
            color: StreamChatTheme.of(context).colorTheme.textLowEmphasis,
          );
    }

    if (message.status == MessageSendingStatus.sending ||
        message.status == MessageSendingStatus.updating) {
      //* INNO NOTE: edit this.
      return sendingOrUpdatingIndicatorBuilder?.call(message) ??
          Icon(
            Icons.access_time,
            size: size,
          );
    }

    //* INNO NOTE: add this.
    if ((message.status == MessageSendingStatus.failed ||
            message.status == MessageSendingStatus.failed_update) &&
        failedOrFailedUpdateIndicatorBuilder?.call(message, channel) != null) {
      return failedOrFailedUpdateIndicatorBuilder!.call(message, channel);
    }

    return const SizedBox();
  }
}
