CLASS zcl_fmb_abap_unit_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fmb_abap_unit_1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: ls_producto TYPE lcl_pedido=>ty_producto.

    DATA(lo_pedido) = NEW lcl_pedido(  ).

    ls_producto-id = 1.
    ls_producto-name = 'Producto 1' ##NO_TEXT.
    lo_pedido->agregar_producto( ls_producto ).

    DATA(lt_pedidos) = lo_pedido->listar_productos(  ).

    out->write( lt_pedidos ).

  ENDMETHOD.

ENDCLASS.
