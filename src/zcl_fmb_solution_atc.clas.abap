CLASS zcl_fmb_solution_atc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fmb_solution_atc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lv_mths     TYPE i VALUE 0,
          lv_hols     TYPE i VALUE 10,
          lv_avg_hols TYPE i.

    SELECT FROM /dmo/connection
        FIELDS *
        INTO TABLE @DATA(lt_connections). "#EC CI_NOWHERE

    out->write( lt_connections ).

    IF lv_mths NE 0.
      lv_avg_hols = lv_hols / lv_mths.
      out->write( |Average vacation days per month { lv_avg_hols }  | ) ##NO_TEXT.
    ELSE.
      out->write( |Average vacation days per month { lv_avg_hols }  | ) ##NO_TEXT.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
