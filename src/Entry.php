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

class Entry
{
    /**
     * 第三方平台对象
     * @var null
     */
    public $platform = null;

    /**
     * 第三方平台从属对象
     * @var null
     */
    protected $subordinate = null;

    /**
     * 第三方平台从属对象类型
     * @var string
     */
    protected $type = 1;

    public function __construct(array $config,string $type = 'wechat')
    {
    }

    /**
     * 实例化第三方平台接口
     */
    private function factory()
    {

    }
}