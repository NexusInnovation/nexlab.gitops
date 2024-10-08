using Microsoft.AspNetCore.Mvc;

namespace NexLab.GitOps.App.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class DummyController : ControllerBase
{
    private readonly ILogger<DummyController> _logger;

    public DummyController(ILogger<DummyController> logger)
    {
        _logger = logger;
    }

    [HttpGet("{message}")]
    public string Get(string message)
    {
        return message;
    }
}
