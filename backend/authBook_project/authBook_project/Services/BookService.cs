using authBook_project.Data.Contexts;
using authBook_project.Data.Entities;
using authBook_project.DTOs;
using Microsoft.EntityFrameworkCore;

namespace authBook_project.Services
{
    public class BookService : IBookService
    {
        private readonly ProjectContext _dbcontext;

        public BookService(ProjectContext dbcontext)
        {
            _dbcontext = dbcontext;
        }

        public async Task<List<GetBookDTO>> GetAllBooksAsync()
        {
            return await _dbcontext.Books
                .Select(b => new GetBookDTO
                {
                    Title = b.Title,
                    Author = b.Author,
                    Price = b.Price
                }).ToListAsync();
        }

        public async Task AddBookAsync(BookCreateDTO dto)
        {
            var book = new Book
            {
                Title = dto.Title,
                Author = dto.Author,
                Price = dto.Price
            };
            _dbcontext.Books.Add(book);
            await _dbcontext.SaveChangesAsync();
        }

        public async Task PurchaseBookAsync(string userEmail, int bookId)
        {
            var user = await _dbcontext.Users.FirstOrDefaultAsync(u => u.Email == userEmail);
            if (user == null)
                throw new Exception("User not found");

            var alreadyExists = await _dbcontext.UserBooks
                .AnyAsync(x => x.UserId == user.Id && x.BookId == bookId);

            if (alreadyExists) return;

            var userBook = new UserBook
            {
                UserId = user.Id,
                BookId = bookId,
                PurchaseDate = DateTime.UtcNow
            };

            _dbcontext.UserBooks.Add(userBook);
            await _dbcontext.SaveChangesAsync();
        }

        public async Task<List<BookDTO>> GetPurchasedBooksAsync(string userEmail)
        {
            var user = await _dbcontext.Users.FirstOrDefaultAsync(u => u.Email == userEmail);
            if (user == null)
                throw new Exception("User not found");

            return await _dbcontext.UserBooks
                .Where(ub => ub.UserId == user.Id)
                .Select(ub => new BookDTO
                {
                    Id = ub.Book.Id,
                    Title = ub.Book.Title,
                    Author = ub.Book.Author,
                    Price = ub.Book.Price
                }).ToListAsync();
        }
    }
}