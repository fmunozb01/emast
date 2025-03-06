*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_pedido DEFINITION FINAL.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_producto,
             id   TYPE i,
             name TYPE string,
           END OF ty_producto,
           tt_productos TYPE STANDARD TABLE OF ty_producto WITH DEFAULT KEY.

    METHODS:
      agregar_producto IMPORTING is_producto TYPE ty_producto,
      eliminar_producto IMPORTING iv_id TYPE i,
      listar_productos RETURNING VALUE(rt_productos) TYPE tt_productos.

  PROTECTED SECTION ##SECTION_OK.
  PRIVATE SECTION.
    DATA: mt_productos TYPE tt_productos.

ENDCLASS.

CLASS lcl_pedido IMPLEMENTATION.
  METHOD agregar_producto.
    INSERT is_producto INTO TABLE mt_productos.
  ENDMETHOD.

  METHOD eliminar_producto.
    DELETE mt_productos WHERE id = iv_id.
  ENDMETHOD.

  METHOD listar_productos.
    rt_productos = mt_productos.
  ENDMETHOD.
ENDCLASS.
