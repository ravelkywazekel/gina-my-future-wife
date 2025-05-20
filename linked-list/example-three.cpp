#include <iostream>
#include <unordered_set>

class Node {
public:
    int data;
    Node* next;

    Node(int value) {
        data = value;
        next = nullptr;
    }
};

class LinkedList {
private:
    Node* head;

public:
    LinkedList() {
        head = nullptr;
    }

    // function masukkan node baru di akhir list
    void insert(int value) {
        Node* newNode = new Node(value);
        if (head == nullptr) {
            head = newNode;
            return;
        }
        Node* temp = head;
        while (temp->next != nullptr) {
            temp = temp->next;
        }
        temp->next = newNode;
    }

    // function gabungkan dua linked lists
    LinkedList merge(LinkedList& other) {
        LinkedList mergedList;
        Node* current1 = head;
        Node* current2 = other.head;

        while (current1 != nullptr) {
            mergedList.insert(current1->data);
            current1 = current1->next;
        }

        while (current2 != nullptr) {
            mergedList.insert(current2->data);
            current2 = current2->next;
        }

        return mergedList;
    }

    // function menghapus duplikat dari linked list
    void removeDuplicates() {
        std::unordered_set<int> seen;
        Node* current = head;
        Node* previous = nullptr;

        while (current != nullptr) {
            if (seen.find(current->data) != seen.end()) {
                // duplikat ditemukan, mengahapus
                previous->next = current->next;
                delete current;
                current = previous->next;
            } else {
                // bukan duplikat, tambahkan ke set
                seen.insert(current->data);
                previous = current;
                current = current->next;
            }
        }
    }

    // function menampilkan linked list
    void display() {
        Node* temp = head;
        while (temp != nullptr) {
            std::cout << temp->data << ", ";
            temp = temp->next;
        }
        std::cout << "nullptr" << std::endl;
    }

    // destructor untuk free memory
    ~LinkedList() {
        Node* current = head;
        Node* nextNode;
        while (current != nullptr) {
            nextNode = current->next;
            delete current;
            current = nextNode;
        }
    }
};

int main() {
    LinkedList list1;
    list1.insert(111);
    list1.insert(222);
    list1.insert(333);
    list1.insert(222); // duplikat
    list1.insert(444);
    std::cout << "List 1: ";
    list1.display(); // Output: 111, 222, 333, 222, 444, nullptr

    LinkedList list2;
    list2.insert(555);
    list2.insert(666);
    std::cout << "List 2: ";
    list2.display(); // Output: 666, 777, nullptr

    // menggabungkan list1 dan list2
    LinkedList mergedList = list1.merge(list2);
    std::cout << "gabungan list: ";
    mergedList.display(); // Output: 111, 222, 333, 222, 444, 555, 666, nullptr

    // menghapus duplikat dari gabungan list
    mergedList.removeDuplicates();
    std::cout << "gabungan setelah menghapus duplikat list: ";
    mergedList.display(); // Output: 111, 222, 333, 444, 555, 666, nullptr

    return 0;
}
