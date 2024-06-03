import 'package:flutter/material.dart';
import 'package:http_client_todo/data/products_model.dart';
import 'package:http_client_todo/pages/home_page_detail.dart';
import 'package:http_client_todo/services/client_service.dart';
import 'package:http_client_todo/widgets/my_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getData() async {
    await ClientService.get();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Note App"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: ClientService.list.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        text: ClientService.list[index].text,
                        title: ClientService.list[index].title,
                        dateTime: ClientService.list[index].dateTime,
                        updateTime: ClientService.list[index].updateTime,
                      ),
                    ),
                  );
                },
                title: Text(ClientService.list[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ClientService.list[index].text),
                    Text(ClientService.list[index].dateTime),
                    Text(ClientService.list[index].updateTime),
                  ],
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        TextEditingController editTitleController =
                            TextEditingController(
                                text: ClientService.list[index].title);
                        TextEditingController editTextController =
                            TextEditingController(
                                text: ClientService.list[index].text);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return MyDialog(
                              titleControllers: editTitleController,
                              textControllers: editTextController,
                              onPressed: () async {
                                NoteModel noteModel = NoteModel(
                                    title: editTitleController.text,
                                    text: editTextController.text,
                                    dateTime:
                                        ClientService.list[index].dateTime,
                                    updateTime: DateTime.now().toString(),
                                    id: "id");
                                await ClientService.put(
                                    id: ClientService.list[index].id,
                                    data: noteModel);
                                await ClientService.get();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ClientService.delete(
                            id: ClientService.list[index].id);
                        await ClientService.get();
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return MyDialog(
                titleControllers: titleController,
                textControllers: textController,
                onPressed: () async {
                  NoteModel noteModel = NoteModel(
                      title: titleController.text,
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                      updateTime: "",
                      id: "id");
                  await ClientService.post(
                      api: ClientService.apiProducts, data: noteModel);
                  await ClientService.get();
                  Navigator.pop(context);
                  setState(() {});
                  textController.clear();
                  titleController.clear();
                  setState(() {});
                },
              );
            },
          );
        },
      ),
    );
  }
}
