#include <Windows.h>
#pragma comment(lib, "d2d1.lib")
#include <d2d1_3.h>
#include <cassert>

constexpr int WIDTH = 800;
constexpr int HEIGHT = 600;

constexpr wchar_t WINDOW_CLASS_NAME[] = L"MyD2DWindowClass";
constexpr wchar_t WINDOW_TITLE[] = L"MyD2D Sample";

class MyD2D {
public:
    explicit MyD2D(HWND hwnd) {
        const HRESULT hrFactory = D2D1CreateFactory(
            D2D1_FACTORY_TYPE_SINGLE_THREADED,
            &factory_);
        assert(SUCCEEDED(hrFactory));

        const HRESULT hrRenderTarget = factory_->CreateHwndRenderTarget(
            D2D1::RenderTargetProperties(),
            D2D1::HwndRenderTargetProperties(
                hwnd,
                D2D1::SizeU(WIDTH, HEIGHT)),
            &renderTarget_);
        assert(SUCCEEDED(hrRenderTarget));
    }
    ~MyD2D() {
        if (renderTarget_ != nullptr) {
            renderTarget_->Release();
        }
        if (factory_ != nullptr) {
            factory_->Release();
        }
    }
    void resize(UINT width, UINT height) {
        if (renderTarget_ == nullptr) {
            return;
        }
        const HRESULT hr = renderTarget_->Resize(D2D1::SizeU(width, height));
        assert(SUCCEEDED(hr));
    }
    void paint() {
        assert(renderTarget_ != nullptr);
        renderTarget_->BeginDraw();
        renderTarget_->Clear(D2D1::ColorF(D2D1::ColorF::WhiteSmoke));
        const HRESULT hr = renderTarget_->EndDraw();
        assert(SUCCEEDED(hr));
    }
    ID2D1HwndRenderTarget* getRenderTarget() {
        return renderTarget_;
    }
private:
    ID2D1Factory8* factory_ = nullptr;
    ID2D1HwndRenderTarget* renderTarget_ = nullptr;
};

LRESULT CALLBACK WindowProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    auto* myD2D = reinterpret_cast<MyD2D*>(GetWindowLongPtrW(hwnd, GWLP_USERDATA));

    switch (message) {
    case WM_CREATE:
        myD2D = new MyD2D(hwnd);
        SetWindowLongPtrW(hwnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(myD2D));
        return 0;

    case WM_SIZE:
        if (myD2D != nullptr) {
            myD2D->resize(LOWORD(lParam), HIWORD(lParam));
        }
        return 0;

    case WM_PAINT: {
        PAINTSTRUCT ps{};
        BeginPaint(hwnd, &ps);
        if (myD2D != nullptr) {
            myD2D->paint();
        }
        EndPaint(hwnd, &ps);
        return 0;
    }

    case WM_DESTROY:
        delete myD2D;
        SetWindowLongPtrW(hwnd, GWLP_USERDATA, 0);
        PostQuitMessage(0);
        return 0;
    }

    return DefWindowProcW(hwnd, message, wParam, lParam);
}

int WINAPI wWinMain(HINSTANCE instance, HINSTANCE, PWSTR, int cmdShow) {
    WNDCLASSW wc{};
    wc.lpfnWndProc = WindowProc;
    wc.hInstance = instance;
    wc.lpszClassName = WINDOW_CLASS_NAME;
    wc.hCursor = LoadCursorW(nullptr, IDC_ARROW);

    const ATOM registered = RegisterClassW(&wc);
    assert(registered != 0);

    HWND hwnd = CreateWindowExW(
        0,
        WINDOW_CLASS_NAME,
        WINDOW_TITLE,
        WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        WIDTH,
        HEIGHT,
        nullptr,
        nullptr,
        instance,
        nullptr);
    assert(hwnd != nullptr);

    ShowWindow(hwnd, cmdShow);
    UpdateWindow(hwnd);

    MSG msg{};
    while (GetMessageW(&msg, nullptr, 0, 0) > 0) {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }

    return 0;
}