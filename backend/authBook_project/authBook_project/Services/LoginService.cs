using authBook_project.Data.Contexts;
using authBook_project.DTOs;
using authBook_project.Handlers;
using Microsoft.EntityFrameworkCore;

namespace authBook_project.Services
{
    public class LoginService : ILoginService
    {

        private readonly ProjectContext _dbContext;
        private readonly ITokenService _tokenService;

        public LoginService(ProjectContext dbContext, ITokenService tokenService)
        {
            _dbContext = dbContext;
            _tokenService = tokenService;
        }

        public async Task<LoginResponseDTO?> LoginAsync(LoginRequestDTO request)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Email == request.Email);
            if (user == null || !PasswordHashHandler.VerifyPassword(request.Password, user.PasswordHash))
                return null;

            return await _tokenService.Authenticate(request);
        }
    }
}
