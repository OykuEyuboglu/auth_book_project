using authBook_project.DTOs;
using authBook_project.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace authBook_project.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookController : ControllerBase
    {
        private readonly IBookService _bookService;

        public BookController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpGet("all")]
        public async Task<IActionResult> GetAllBooks()
        {
            var books = await _bookService.GetAllBooksAsync();
            return Ok(books);
        }

        [HttpPost("add")]
        public async Task<IActionResult> AddBook([FromBody] BookCreateDTO dto)
        {
            await _bookService.AddBookAsync(dto);
            return Ok();
        }

        [Authorize]
        [HttpPost("purchase")]
        public async Task<IActionResult> PurchaseBook([FromBody] UserBookDTO dto)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userEmail))
                return Unauthorized("User email claim not found.");

            await _bookService.PurchaseBookAsync(userEmail, dto.BookId);
            return Ok();
        }

        [Authorize]
        [HttpGet("mybooks")]
        public async Task<IActionResult> GetMyBooks()
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userEmail))
                return Unauthorized("User email claim not found.");

            var books = await _bookService.GetPurchasedBooksAsync(userEmail);
            return Ok(books);
        }

        [Authorize]
        [HttpDelete("delete/{bookId}")]
        public async Task<IActionResult> DeleteBook(int bookId)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userEmail))
                return Unauthorized("Email not found");

            await _bookService.DeletePurchasedBookAsync(userEmail, bookId);
            return Ok();
        }
    }
}
