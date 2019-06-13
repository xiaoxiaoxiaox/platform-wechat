<?php
/**
 * Url: http://xxcok.com
 * Author: Andy
 * Date: 0010 6-10
 * Time: 19:33
 *
 *  .--,       .--,
 * ( (  \.---./  ) )
 *  '.__/o   o\__.'
 *     {=  ^  =}
 *      >  -  <
 *     /       \
 *    //       \\
 *   //|   .   |\\
 *   "'\       /'"_.-~^`'-.
 *      \  _  /--'         `
 *    ___)( )(___
 *   (((__) (__)))    高山仰止,景行行止.虽不能至,心向往之。
 * -----------------------------------------------------
 */

namespace andy\platform;

use andy\platform\exception\CreateException;
use EasyWeChat\Factory;
use Symfony\Component\Cache\Simple\RedisCache;

class Entry
{
    /**
     * 第三方平台对象
     * @var null
     */
    public $app = null;

    /**
     * 第三方平台从属对象类型
     * @var string  1:公众号 2:小程序 3:表示公众号和小程序
     */
    protected $type = 3;

    /**
     * 第三方平台配置
     * @var array
     */
    private $open_platform_config = [
        'app_id'   => '',   //开放平台第三方平台 APPID
        'secret'   => '',   //开放平台第三方平台 Secret
        'token'    => '',   //开放平台第三方平台 消息校验Token
        'aes_key'  => ''    //开放平台第三方平台 消息加解密Key
    ];

    /**
     * 数据库配置
     * @example ./
     * @var array
     */
    private $db_config = [
        'type' => 'mysql',  //数据库类型
        'host' => '127.0.0.1',  //数据库地址
        'user' => 'root',   //账号
        'password' => '123456', //密码
        'port' => 3306, //端口
        'database' => 'open_platform',    //数据库名称
        'prefix' => ''  //前缀
    ];

    /**
     * 缓存配置
     * @var array
     */
    private $cache_config = [
        'type' => 'default',    //使用默认文件缓存的形式
//            'type' => 'redis' //使用redis缓存
        'host' => '',    //redis地址
        'port' => '',   //redis端口
        'password' => ''  //redis密码
    ];

    /**
     * Entry constructor.
     * @param array $config
     * @example [
     *      'open_platform' => [
     *           'app_id'   => '',   //开放平台第三方平台 APPID
     *           'secret'   => '',   //开放平台第三方平台 Secret
     *           'token'    => '',   //开放平台第三方平台 消息校验Token
     *           'aes_key'  => ''    //开放平台第三方平台 消息加解密Key
     *      ],
     *      'cache' => [
     *           'type' => 'redis' //使用redis缓存
     *           'host' => '127.0.0.1',    //redis地址
     *           'port' => '6379',   //redis端口
     *           'password' => ''  //redis密码
     *      ],
     *      'db' => [
     *           'type' => 'mysql',  //数据库类型
     *           'host' => '127.0.0.1',  //数据库地址
     *           'user' => 'root',   //账号
     *           'password' => '123456', //密码
     *           'port' => 3306, //端口
     *           'database' => 'open_platform',    //数据库名称
     *           'prefix' => ''  //前缀
     *      ]
     * ]
     */
    public function __construct(array $config)
    {
        $this->init($config);   //初始化
    }

    /**
     * 获取第三方平台接口
     */
    public function getPlatform()
    {
        return $this->app;
    }

    /**
     * 获取第三方平台下属对象
     */
    public function getAuthorization()
    {
        return;
    }

    /**
     * 驱动初始化
     * @param $config
     */
    private function init($config)
    {
        $this->setConfig($config);  //设置配置

        $this->app = Factory::openPlatform($this->open_platform_config);   //获取第三方平台对象

        $this->setCache();

        $this->setDb();

    }

    /**
     * 更新配置
     * @param array $config
     */
    private function setConfig(array $config) :void
    {
        $open_platform_config = $config['open_platform'] ?? []; //开放平台配置文件
        $this->open_platform_config = array_only($this->open_platform_config, $open_platform_config);

        $db_config = $config['db'] ?? [];   //数据库配置
        $this->db_config = array_only($this->db_config, $db_config);

        $cache_config = $config['cache'] ?? []; //缓存配置
        $this->cache_config = array_only($this->cache_config, $cache_config);
    }

    /**
     * 设置缓存驱动
     */
    private function setCache()
    {
        $type = $this->cache_config['type'];

        switch ($type) {
            case 'redis':   //使用redis处理缓存
                $redis = new \Redis();
                $result = $redis->connect($this->cache_config['host'], $this->cache_config['port']);
                if ($result === false) {
                    throw new CreateException('连接redis服务器失败');
                }

                // 创建缓存实例
                $cache = new RedisCache($redis);

                // 替换应用中的缓存
                $this->app->rebind('cache', $cache);
                break;
            default:
                break;
        }
    }

    /**
     * 设置数据库
     */
    private function setDb()
    {

    }
}