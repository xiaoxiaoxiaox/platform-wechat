<?php
/**
 * Url: http://xxcok.com
 * Author: Andy
 * Date: 0013 6-13
 * Time: 16:24
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
if (!function_exists('array_only')) {
    /**
     * 仅获取old数组的key数据
     * @param array $old
     * @param array $new
     * @return array
     */
    function array_only(array $old, array $new) : array
    {
        return array_merge($old, array_intersect_key($new, $old));
    }
}
