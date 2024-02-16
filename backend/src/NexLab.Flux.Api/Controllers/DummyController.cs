using Microsoft.AspNetCore.Mvc;

namespace NexLab.Flux.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class DummyController : ControllerBase
{
    private readonly ILogger<DummyController> _logger;

    public DummyController(ILogger<DummyController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public DummyResponse Get()
    {
        return new DummyResponse("B");
    }
}
