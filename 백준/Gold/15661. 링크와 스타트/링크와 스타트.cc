#include <iostream>
#include<limits>

using namespace std;

int n;
int map[20][20];
bool visited[20];
int result = numeric_limits<int>::max();

int cal() {
    int t1 = 0;
    int t2 = 0;

    for(int i = 0; i < n - 1; i++) {
        for(int j = i + 1; j < n; j++) {
            if(visited[i] && visited[j]) {
                t1 += map[i][j] + map[j][i];
            } else if(!visited[i] && !visited[j]) {
                t2 += map[i][j] + map[j][i];
            }
        }
    }

    return abs(t1 - t2);
}

void divide(int count, int start) {
    if (count > n / 2) { return; }
    if (count > 0) {
        result = min(result, cal());
    }
    for (int i = start; i < n; i++) {
        visited[i] = true;
        divide(count + 1, i + 1);
        visited[i] = false;
    }
}

int main() {
    ios::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);

    cin >> n;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j< n; j++) {
            cin >> map[i][j];
        }
    }
    divide(0, 0);
    cout << result;
    return 0;
}