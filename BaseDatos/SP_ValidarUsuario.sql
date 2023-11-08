SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Valida que el usuario exista, retorna un -1 si no existe, de lo contrario retorna el tipo de usuario correspondiente
ALTER PROCEDURE ValidarUsuario
	
	@inCorreo	VARCHAR(128),
	@inPassword	VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;

	
    IF NOT EXISTS (
		SELECT U.Correo
		FROM [dbo].[Usuario] U
		WHERE BINARY_CHECKSUM(U.Correo) = BINARY_CHECKSUM(@inCorreo) 
		AND BINARY_CHECKSUM(U.Password) = BINARY_CHECKSUM(@inPassword)
		)
		BEGIN
			SELECT -1 -- Login Fallido
		END;

		ELSE
		-- Login Exitoso
		BEGIN
			SELECT U.IdTipoUsuario
			FROM [dbo].[Usuario] U
			WHERE (U.Correo = @inCorreo)
		END;

END
GO