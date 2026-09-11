import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Complete Flutter assignment', 'completed': false},
    {'title': 'Review Dart concepts', 'completed': true},
    {'title': 'Build something amazing', 'completed': false},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Add a new task
  void _addTask() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _tasks.insert(0, {'title': text, 'completed': false});
    });

    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  // Delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Mark task as complete/incomplete
  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  int get _completedCount {
    return _tasks.where((task) => task['completed'] == true).length;
  }

  int get _remainingCount {
    return _tasks.where((task) => task['completed'] == false).length;
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _tasks.isEmpty
        ? 0
        : _completedCount / _tasks.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good evening.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF777777),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'My Tasks',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.2,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),

                      // Task count
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          '${_tasks.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ---------------- PROGRESS CARD ----------------
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Today\'s progress',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Keep going.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              '${(progress * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 7,
                            backgroundColor: Colors.white12,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$_completedCount completed',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '$_remainingCount remaining',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- TASK LIST ----------------
            Expanded(
              child: _tasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 120),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return _buildTaskCard(index);
                      },
                    ),
            ),
          ],
        ),
      ),

      // ---------------- ADD TASK BUTTON ----------------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GestureDetector(
          onTap: _showAddTaskSheet,
          child: Container(
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 25),
                SizedBox(width: 8),
                Text(
                  'Add new task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TASK CARD ----------------

  Widget _buildTaskCard(int index) {
    final task = _tasks[index];
    final bool completed = task['completed'];

    return Dismissible(
      key: ValueKey('${task['title']}_$index'),
      direction: DismissDirection.endToStart,

      onDismissed: (_) {
        _deleteTask(index);
      },

      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 22),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: completed ? const Color(0xFFEDEDEB) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: completed
                ? const Color(0xFFE2E2DF)
                : const Color(0xFFEAEAE7),
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () => _toggleTask(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: completed
                      ? const Color(0xFF111111)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: completed
                        ? const Color(0xFF111111)
                        : const Color(0xFFBBBBB7),
                    width: 1.5,
                  ),
                ),
                child: completed
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                    : null,
              ),
            ),

            const SizedBox(width: 14),

            // Task title
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: completed
                      ? const Color(0xFF999996)
                      : const Color(0xFF202020),
                  decoration: completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: const Color(0xFF999996),
                ),
                child: Text(
                  task['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Delete button
            GestureDetector(
              onTap: () => _deleteTask(index),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: completed
                      ? const Color(0xFFE4E4E1)
                      : const Color(0xFFF4F4F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 19,
                  color: completed
                      ? const Color(0xFF999999)
                      : const Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- EMPTY STATE ----------------

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAE7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 34,
                color: Color(0xFF777777),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'All clear.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add a task and get things moving.',
              style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ADD TASK BOTTOM SHEET ----------------

  void _showAddTaskSheet() {
    _controller.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0D0CC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'New task',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'What do you want to accomplish?',
                  style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) {
                    if (_controller.text.trim().isNotEmpty) {
                      _addTask();
                      Navigator.pop(context);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your task...',
                    hintStyle: const TextStyle(color: Color(0xFFAAAAA6)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 17,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        _addTask();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF111111),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Create task',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
