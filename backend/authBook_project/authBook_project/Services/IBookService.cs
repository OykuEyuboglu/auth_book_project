using authBook_project.DTOs;

namespace authBook_project.Services
{
    public interface IBookService
    {
        Task<List<BookDTO>> GetAllBooksAsync();
        Task AddBookAsync(BookCreateDTO dto);
        Task PurchaseBookAsync(string UserEmail, int bookId);
        Task<List<BookDTO>> GetPurchasedBooksAsync(string UserEmail);
        Task DeletePurchasedBookAsync(string userEmail, int bookId);
    }
}
