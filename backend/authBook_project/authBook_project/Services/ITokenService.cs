using authBook_project.DTOs;

namespace authBook_project.Services
{
    public interface ITokenService
    {
        Task<LoginResponseDTO?> Authenticate(LoginRequestDTO request);
    }
}
