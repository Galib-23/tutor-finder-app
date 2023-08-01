import 'package:flutter/material.dart';

class TuitionWidget extends StatefulWidget {
  final String subject;
  final String tuitionDescription;
  final String tuitionId;
  final String uploadedBy;
  final String userImage;
  final String name;
  final bool hiring;
  final String email;
  final String location;

  const TuitionWidget({
    super.key,
    required this.subject,
    required this.tuitionDescription,
    required this.tuitionId,
    required this.uploadedBy,
    required this.userImage,
    required this.name,
    required this.hiring,
    required this.email,
    required this.location,
  });

  @override
  State<TuitionWidget> createState() => _TuitionWidgetState();
}

class _TuitionWidgetState extends State<TuitionWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        onTap: () {},
        onLongPress: () {},
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: Image.network(widget.userImage),
        ),
        title: Text(
          widget.subject,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.tuitionDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
