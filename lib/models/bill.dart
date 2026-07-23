enum BillStatus { paid, unpaid, overdue }

class Bill {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final BillStatus status;
  final String? gstNumber;

  Bill({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    this.status = BillStatus.unpaid,
    this.gstNumber,
  });
}
