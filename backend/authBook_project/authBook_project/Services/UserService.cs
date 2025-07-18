﻿using authBook_project.Data.Contexts;
using authBook_project.DTOs;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace authBook_project.Services
{
    public class UserService : IUserService
    {
        private readonly ProjectContext _dbContext;
        public UserService(ProjectContext dbContext) 
        {
            _dbContext = dbContext;
        }


        public async Task<List<UserProfilDTO>> GetAllUsersAsync()
        {
            return await _dbContext.Users
                .Select(u => new UserProfilDTO
                {
                    Username = u.UserName,
                    Email = u.Email
                })
                .ToListAsync();
        }

        public async Task<UserProfilDTO> GetUserProfilAsync(ClaimsPrincipal user)
        {
            var email = user.FindFirstValue(ClaimTypes.Email) ?? user.FindFirstValue("email");
            if (email == null) return null;

            var entity = await _dbContext.Users.FirstOrDefaultAsync(x => x.Email == email);
            if (entity == null) return null;

            return new UserProfilDTO
            {
                Email = entity.Email,
                Username = entity.UserName,
            };
        }
    }
}
