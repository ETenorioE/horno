import 'package:flutter/material.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de Pedidos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 250, 104, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber,
          child: Center(
            child: Column(
              children: [
                //CARD 1
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 20, bottom: 10),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/progreso.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Progreso',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 159, 0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 2
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/terminado.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Terminado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 3
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 20, left: 20, top: 0.0),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cancelado.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Cancelado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 4
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/terminado.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Terminado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 5
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/terminado.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Terminado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 6
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 20, left: 20, top: 0.0),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/progreso.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Progreso',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 159, 0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //CARD 7
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 20, left: 20, top: 0.0),
                  child: Card(
                    elevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 116,
                      width: 372,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NUMERO DE PEDIDO
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 11, bottom: 17),
                            child: Text(
                              'Numero de orden # 453',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              //ICONO
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Container(
                                  width: 52,
                                  height: 49,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cancelado.png'),
                                    ),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    //ESTADO
                                    Text(
                                      'Cancelado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    //FECHA
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '22-05-01 14:16:04',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 194, 184, 194),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //PRECIO
                              const Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 40),
                                child: Text(
                                  'S/73.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 99, 69, 97),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
