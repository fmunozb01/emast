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
*      test_main              FOR TESTING.
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


*  METHOD test_main.
**    DATA(lo_abap_unit) = NEW zcl_fmb_abap_unit_1(  ).
**    DATA: lo_out TYPE REF TO if_oo_adt_classrun_out.
**    cl_abap_unit_assert=>skip( msg = 'La prueba se salta' ).
**    lo_abap_unit->if_oo_adt_classrun~main( out = lo_out ).
*
*  ENDMETHOD.

ENDCLASS.
