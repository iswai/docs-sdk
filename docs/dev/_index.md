---
title: DevOps
version: "1.1.x-dev"
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et malesuada fames ac turpis egestas integer eget. Cursus mattis molestie a iaculis at. Eleifend mi in nulla posuere sollicitudin. Lectus mauris ultrices eros in cursus turpis massa. Morbi tristique senectus et netus et malesuada fames. Gravida quis blandit turpis cursus in hac habitasse platea. Pellentesque id nibh tortor id. Varius morbi enim nunc faucibus a pellentesque sit amet. Lacus laoreet non curabitur gravida arcu ac.

```php
<?php
/**
 * @see       https://github.com/zendframework/zend-expressive for the canonical source repository
 * @copyright Copyright (c) 2015-2018 Zend Technologies USA Inc. (https://www.zend.com)
 * @license   https://github.com/zendframework/zend-expressive/blob/master/LICENSE.md New BSD License
 */

declare(strict_types=1);

namespace Zend\Expressive;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Zend\Expressive\Router\RouteCollector;
use Zend\HttpHandlerRunner\RequestHandlerRunner;
use Zend\Stratigility\MiddlewarePipeInterface;

use function Zend\Stratigility\path;

class Application implements MiddlewareInterface, RequestHandlerInterface
{
    /** @var MiddlewareFactory */
    private $factory;

    /** @var MiddlewarePipeInterface */
    private $pipeline;

    /** @var RouteCollector */
    private $routes;

    /** @var RequestHandlerRunner */
    private $runner;

    public function __construct(
        MiddlewareFactory $factory,
        MiddlewarePipeInterface $pipeline,
        RouteCollector $routes,
        RequestHandlerRunner $runner
    ) {
        $this->factory = $factory;
        $this->pipeline = $pipeline;
        $this->routes = $routes;
        $this->runner = $runner;
    }

    /**
     * Proxies to composed pipeline to handle.
     * {@inheritDocs}
     */
    public function handle(ServerRequestInterface $request) : ResponseInterface
    {
        return $this->pipeline->handle($request);
    }

    /**
     * Run the application.
     *
     * Proxies to the RequestHandlerRunner::run() method.
     */
    public function run() : void
    {
        $this->runner->run();
    }
}
```
