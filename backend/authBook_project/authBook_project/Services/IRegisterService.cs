using authBook_project.DTOs;

namespace authBook_project.Services
{
    public interface IRegisterService
    {
        Task<bool> RegisterAsync(RegisterDTO request);

    }
}
