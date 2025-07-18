using authBook_project.DTOs;

namespace authBook_project.Services
{
    public interface ILoginService
    {
        Task<LoginResponseDTO?> LoginAsync(LoginRequestDTO request);
    }
}
