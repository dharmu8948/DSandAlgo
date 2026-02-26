//  Bit Manupulation based problems
#include <bits/stdc++.h>
using namespace std;
void swapNumber(int a, int b) {
    
    a = a^b;
	b = a^b;
	a = a^b;
	cout<<"Swapped Numbers is : "<<a<<"  and "<<b<<endl;
}

void checkithBit(int n, int ithBit) {
    if((n & (1 << ithBit)) != 0) { //we can use right shift as well formula is ((n>>i)&1) != 0 then set else unset
        cout<<"Yes!! "<<ithBit<<" bit is set"<<endl;
    }
    else {
        cout<<"No! "<<ithBit<<" bit is not set"<<endl;
    }
}

void setithBit(int n, int ithBit) {
    cout<<"given number is "<<n<<endl;
    n = (n | (1<<ithBit)); // 1001 | (00...1 << 2) = 1001 | (00...10) = 1101 = 13
    cout<<"Number became "<<n<<" after "<<ithBit<<" bit is set"<<endl;
}

void clearIthBit(int n, int ithBit) {
    cout<<"given number is "<<n<<endl;
    n = (n & ~(1 << ithBit)); //n =13-> 1101 & ~(00...1 << 2) = 1101 | ~(00...100) = 1101 & (11..011) 1001 = 9
    cout<<"Number became "<<n<<" after "<<ithBit<<" bit is Clear"<<endl;
}

void toggleIthBit(int n, int ithBit) {
    cout<<"given number is "<<n<<endl;
    n = (n ^ (1 << ithBit)); //n =13-> 1101 ^ (00...1 << 2) = 1101 ^ (00...100) = 1001 = 9
    cout<<"Number became "<<n<<" after "<<ithBit<<" bit is Toggled"<<endl;
}

void removeLastSetBit(int n) {
    cout<<"given number is "<<n<<endl;
    n = (n & (n-1)); 
    cout<<"Number became "<<n<<" after removing the last set bit"<<endl; 
}

void checkPowerOf2(int num) {
    cout<<"given number is "<<num<<endl;
    if(num & (num-1) == 0) //n = 16 -> 10000 & (01111) -> 00000 -> 0
       cout<<"Yes!! Number "<<num<<" is power of 2"<<endl;
    else 
       cout<<"No! Number "<<num<<" is not power of 2"<<endl;
}
// Approach 1
// void countSetBits(int num) {
//     int cnt = 0;
//     while(num > 1) {
//         cnt += (num & 1); // check if number is odd return 1 and add it into cnt var
//         num = num >> 1;
//     }
//     if(num == 1) cnt+=1;
//     cout<<"Given Number has "<<cnt<<" set Bits"<<endl;
// }
// Approach 2
void countSetBits(int num) {
    int cnt = 0;
    while(num != 0) {
        num = num & (num-1);
        cnt++;
    }
    cout<<"Given Number has "<<cnt<<" set Bits"<<endl;
}
int main() {
	// 1.  swap two numbers
// 	int a = 5, b = 7;
// 	swapNumber(a, b);
	// 2. check if ith bit is set or not
// 	int n = 13, i = 2; // 13 = 1101
// 	checkithBit(n, i);
    // 3. set ith bit
    // int n = 9, i = 2; // 9 = 1001 output : 1101 = 13
    // setithBit(n, i);
    // 4. Clear ith bit
    // int n = 13, i = 2; // 13 = 1101 output : 1001 = 9
    // clearIthBit(n, i);
    // 5. Toggle ith bit
    // int n = 13, i = 1; // 13 = 1101 output : 1001 = 9
    // toggleIthBit(n, i);
    // 6. Remove last set bit
    // int n = 12; //12 -> 1100 output : 1000 = 8
    // removeLastSetBit(n);
    // 7. check if number is power of 2 
    // int n = 16;
    // checkPowerOf2(n); // 16 = 10000 here one set bit so yes, else no
    // 8. Count Number of Set Bits
    int n = 16; // n = 16 -> 10000 -> output: 1 
    countSetBits(n);
	
	return 0;
}
