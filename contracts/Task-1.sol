// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Task1 {
    // 反转字符串
    function reverse(string memory str) public pure returns (string memory) {
        bytes memory b1 = bytes(str);
        uint len = b1.length;
        bytes memory b2 = new bytes(len);

        for (uint i = 0; i < len; ++i) {
            b2[len - 1 - i] = b1[i];
        }

        return string(b2);
    }

    // 罗马数字转整数
    function romanToInt(string memory romanStr) public pure returns (uint) {
        uint result;
        uint prev = 0;

        string memory keys = "CDILMVX";
        uint16[7] memory values = [100, 500, 1, 50, 1000, 5, 10];

        uint len = bytes(romanStr).length;
        bytes memory remanArr = bytes(romanStr);

        for (uint i = len; i > 0; ) {
            --i;
            uint curr = values[strIndexOf(keys, remanArr[i])];
            if (curr < prev) {
                result -= curr;
            } else {
                result += curr;
            }
            prev = curr;
        }

        return result;
    }

    // 查找字母在字符串的第几位
    function strIndexOf(
        string memory str,
        bytes1 char
    ) private pure returns (uint) {
        bytes memory s = bytes(str);
        uint len = s.length;

        for (uint i = 0; i < len; i++) {
            if (char == s[i]) {
                return i;
            }
        }

        return 0;
    }

    // 整数转罗马数字函数
    function intToRoman(uint256 num) public pure returns (string memory) {
        // 确保输入在有效范围内 (1 到 3999)
        require(num > 0 && num <= 3999, "Number must be between 1 and 3999");

        // 显式指定数组类型为uint256[]
        uint256[] memory values = new uint256[](13);
        values[0] = 1000;
        values[1] = 900;
        values[2] = 500;
        values[3] = 400;
        values[4] = 100;
        values[5] = 90;
        values[6] = 50;
        values[7] = 40;
        values[8] = 10;
        values[9] = 9;
        values[10] = 5;
        values[11] = 4;
        values[12] = 1;

        // 显式初始化字符串数组
        string[] memory symbols = new string[](13);
        symbols[0] = "M";
        symbols[1] = "CM";
        symbols[2] = "D";
        symbols[3] = "CD";
        symbols[4] = "C";
        symbols[5] = "XC";
        symbols[6] = "L";
        symbols[7] = "XL";
        symbols[8] = "X";
        symbols[9] = "IX";
        symbols[10] = "V";
        symbols[11] = "IV";
        symbols[12] = "I";

        string memory result = "";

        // 从最大的数值开始处理
        for (uint256 i = 0; i < values.length; i++) {
            // 当当前数值小于等于剩余数值时，添加对应的罗马数字
            while (values[i] <= num) {
                result = string(abi.encodePacked(result, symbols[i]));
                num -= values[i];
            }

            // 如果数值已经减为0，提前退出循环
            if (num == 0) {
                break;
            }
        }

        return result;
    }

    // 合并两个已升序的数组，返回新的升序数组
    function mergeSorted(
        uint256[] memory a,
        uint256[] memory b
    ) public pure returns (uint256[] memory c) {
        uint256 lenA = a.length;
        uint256 lenB = b.length;
        c = new uint256[](lenA + lenB);

        uint256 i; // 指向 a
        uint256 j; // 指向 b
        uint256 k; // 指向 c

        while (i < lenA && j < lenB) {
            if (a[i] < b[j]) {
                c[k++] = a[i++];
            } else {
                c[k++] = b[j++];
            }
        }

        // 处理尾数
        while (i < lenA) c[k++] = a[i++];
        while (j < lenB) c[k++] = b[j++];
    }

    // 从目标数组中查找目标值，返回目标值的下标
    function findValueFromArr(
        uint256[] memory targetArr,
        uint256 num
    ) public pure returns (uint256) {
        uint256 lo = 0;
        uint256 hi = targetArr.length;
        while (lo < hi) {
            uint256 mid = (lo + hi) >> 1;
            if (targetArr[mid] > num)
                lo = mid + 1; // 降序，大的在左
            else hi = mid;
        }
        if (lo < targetArr.length && targetArr[lo] == num) return lo;
        return type(uint256).max;
    }
}
