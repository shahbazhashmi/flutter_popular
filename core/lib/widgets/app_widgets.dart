library sharedcode;

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;

  const CustomDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        )
      ],
    ));
  }
}

class Loading extends StatelessWidget {
  final String? loadingMessage;

  const Loading({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage ?? "loading...",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String? error;
  final String? retryText;

  final Function? onRetryPressed;

  const Error({Key? key, this.error, this.onRetryPressed, this.retryText = "Retry"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              error ?? "something went wrong",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: Text(retryText ?? "Retry", style: const TextStyle(color: Colors.black)),
            onPressed: () => onRetryPressed?.call(),
          )
        ],
      ),
    );
  }
}
