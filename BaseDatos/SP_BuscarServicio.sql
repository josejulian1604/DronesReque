SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BuscarServicio
	
	@inID		VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		S.Descripcion,
		S.Costo,
		S.Cultivo,
		S.FechaContrato,
		S.FechaInicio,
		S.FechaFin,
		S.Estado,
		S.Area
	FROM Servicio S
	WHERE S.id = @inID;
	
	SET NOCOUNT OFF
END
GO