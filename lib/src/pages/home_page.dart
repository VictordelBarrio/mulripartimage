import 'package:blocpattern/src/bloc/provider.dart';
import 'package:blocpattern/src/models/producto_model.dart';
import 'package:blocpattern/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  Future<List<ProductoModel>> fetchingProducts;

  @override
  void initState() {
    super.initState();
    fetchingProducts = productosProvider.cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.lightBlueAccent,
      onPressed: () => Navigator.pushNamed(context, 'Productos'),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: fetchingProducts,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              fetchingProducts = productosProvider.cargarProductos();
              setState(() {});
              await fetchingProducts;
            },
            child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (contex, i) => _crearItem(context, productos[i])),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    Widget productDetails = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${producto.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          Expanded(child: Container()),
          Text(
            '\$${producto.valor.toStringAsFixed(2)} pesos',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );

    Widget _productImage() {
      if (producto.fotoUrl == null) {
        return Image(image: AssetImage('assets/no-image.png'));
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.blueGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue,
              offset: Offset(0, 3.0),
              blurRadius: 20.0,
            )
          ],
          border: Border.all(
            color: Color(0xFF00796B),
            width: 3,
          ),
        ),
        child: ClipOval(
          child: FadeInImage(
            image: NetworkImage(producto.fotoUrl),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 150,
            alignment: Alignment.center,
            width: 150.0,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget cardContent = Container(
      height: 170.0,
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _productImage(),
          Expanded(
            child: productDetails,
          )
        ],
      ),
    );

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        productosProvider.borrarProducto(producto.id);
      },
      child: InkWell(
        splashColor: Colors.lightBlue,
        onTap: () =>
            Navigator.pushNamed(context, 'Productos', arguments: producto),
        child: Card(
          child: Ink(
            child: cardContent,
          ),
        ),
      ),
    );
  }
}
/* 
*/