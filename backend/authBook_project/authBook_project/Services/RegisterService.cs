﻿using authBook_project.Data.Contexts;
using authBook_project.Data.Entities;
using authBook_project.DTOs;
using authBook_project.Handlers;
using Microsoft.EntityFrameworkCore;

namespace authBook_project.Services
{
    public class RegisterService : IRegisterService
    {
        private readonly ProjectContext _dbContext;

        public RegisterService(ProjectContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<bool> RegisterAsync(RegisterDTO request)
        {
            var exists = await _dbContext.Users.AnyAsync(u => u.Email == request.Email);
            if (exists) return false;

            var hashPassword = PasswordHashHandler.HashPassword(request.Password);

            _dbContext.Users.Add(new User
            {
                Email = request.Email,
                PasswordHash = hashPassword,
                UserName = request.UserName
            });

            await _dbContext.SaveChangesAsync();
            return true;
        }
    }
}
