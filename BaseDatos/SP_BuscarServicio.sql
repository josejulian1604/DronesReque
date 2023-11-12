SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE BuscarServicio
	
	@inCedula		VARCHAR(128)
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
	FROM [dbo].[Servicio] S
	INNER JOIN [dbo].[Cliente] C ON C.Cedula = @inCedula
	WHERE S.IdCliente = C.Id;
	
	SET NOCOUNT OFF
END
GO