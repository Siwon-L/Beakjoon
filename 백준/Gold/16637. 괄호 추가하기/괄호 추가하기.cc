#include <iostream>
#include<climits>
#include<cmath>
#include<vector>

using namespace std;

int n;
int result = INT_MIN;
string input;

int cal(int f, int s, char oper) {
    int value = f;
    switch(oper) {
        case '+': value += s; break;
        case '-': value -= s; break;
        case '*': value *= s; break;
    }
    return value;
}

void process(int i, int cur) {
    if(i > n - 1) {
        result = max(result, cur);
        return;
    }

    char oper = i == 0 ? '+' : input[i - 1];

    if(i + 2 < n) {
        int s = cal(input[i] - '0', input[i + 2] - '0', input[i + 1]);
        process(i + 4, cal(cur, s, oper));
    }
    process(i + 2, cal(cur, input[i] - '0', oper));
}

int main() {
    ios::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);
    cin >> n >> input;
    process(0, 0);
    cout << result;
    return 0;
}