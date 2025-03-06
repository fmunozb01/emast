CLASS zcl_fmb_copy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fmb_copy IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lt_zfmbflight TYPE TABLE OF zfmbflight,
          lv_uiid       TYPE i VALUE 0.

    SELECT FROM /dmo/flight AS f
    LEFT JOIN /dmo/connection AS c
    ON c~carrier_id = f~carrier_id
    AND c~connection_id = f~connection_id
    LEFT JOIN /dmo/airport AS af
    ON af~airport_id = c~airport_from_id
    LEFT JOIN /dmo/airport AS at
    ON at~airport_id = c~airport_to_id
    FIELDS f~carrier_id AS carrid,
    c~connection_id AS connid,
    f~flight_date,
    c~airport_from_id AS airport_from,
    af~city AS city_from,
    af~country AS country_from,
    c~airport_to_id AS airport_to,
    at~city AS city_to,
    at~country AS country_to,
    f~price,
    f~currency_code,
    f~plane_type_id
    INTO TABLE @DATA(lt_flight).

    LOOP AT lt_flight ASSIGNING FIELD-SYMBOL(<ls_flight>).

      lv_uiid = lv_uiid + 1.
      APPEND INITIAL LINE TO lt_zfmbflight ASSIGNING FIELD-SYMBOL(<ls_zfmbflight>).
      <ls_zfmbflight> = CORRESPONDING #( <ls_flight> ).
      <ls_zfmbflight>-uuid = lv_uiid.
*      <ls_zfmbflight>-local_created_at = cl_abap_context_info=>get_system_date( ).
      <ls_zfmbflight>-local_created_by = cl_abap_context_info=>get_user_technical_name( ).

    ENDLOOP.

    DELETE FROM zfmbflight.

    MODIFY zfmbflight FROM TABLE @lt_zfmbflight.
    IF sy-subrc = 0.
      out->write( data = lt_zfmbflight name = 'Datos ingresados en la tabla zfmbflight' ).
    ELSE.
      out->write( 'No se pudo ingresar la información en la tabla zfmbflight' ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
