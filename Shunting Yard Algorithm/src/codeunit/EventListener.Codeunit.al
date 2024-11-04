codeunit 53001 "PTE_Event Listener"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", OnAfterCalcCubage, '', false, false)]
    local procedure PTE_ItemUnitofMeasureOnAfterCalcCubage(var ItemUnitOfMeasure: Record "Item Unit of Measure")
    var
        UnitofMeasureMgt: Codeunit "PTE_Unit of Measure Mgt.";
    begin
        if ItemUnitOfMeasure.IsTemporary then
            exit;
        UnitofMeasureMgt.UpdateSurface(ItemUnitOfMeasure);
        UnitofMeasureMgt.UpdateVolume(ItemUnitOfMeasure);
    end;

}
