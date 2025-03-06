*"* use this source file for your ABAP unit test classes
CLASS ltcl_pedido_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
    mo_ped TYPE REF TO lcl_pedido.

    METHODS:
      setup,
      test_agregar_producto  FOR TESTING,
      test_eliminar_producto FOR TESTING,
      test_listar_productos  FOR TESTING.
ENDCLASS.


CLASS ltcl_pedido_test IMPLEMENTATION.
  METHOD setup.
    mo_ped = NEW lcl_pedido(  ).
  ENDMETHOD.

  METHOD test_agregar_producto.
    DATA: ls_producto TYPE lcl_pedido=>ty_producto.

    ls_producto-id = 1.
    ls_producto-name = 'Producto 1'.
    mo_ped->agregar_producto( ls_producto ).

    cl_abap_unit_assert=>assert_equals( act = lines( mo_ped->listar_productos( ) ) exp = 1 ).
  ENDMETHOD.

  METHOD test_eliminar_producto.
    DATA: ls_producto TYPE lcl_pedido=>ty_producto.

    ls_producto-id = 1.
    ls_producto-name = 'Producto 1'.
    mo_ped->agregar_producto( ls_producto ).
    mo_ped->eliminar_producto( 1 ).

    cl_abap_unit_assert=>assert_equals( act = lines( mo_ped->listar_productos( ) ) exp = 0 ).
  ENDMETHOD.

  METHOD test_listar_productos.
    DATA: ls_producto TYPE lcl_pedido=>ty_producto.

    ls_producto-id = 1.
    ls_producto-name = 'Producto 1'.
    mo_ped->agregar_producto( ls_producto ).

    DATA(lt_productos) = mo_ped->listar_productos( ).
    cl_abap_unit_assert=>assert_not_initial( lt_productos ).
  ENDMETHOD.


ENDCLASS.
