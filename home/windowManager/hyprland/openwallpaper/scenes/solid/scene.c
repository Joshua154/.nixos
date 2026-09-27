#include <openwallpaper.h>

__attribute__((export_name("init"))) void init(void) {}

__attribute__((export_name("update"))) void update(float delta) {
    (void)delta;
    ow_render_pass_info pass = {
        .clear_color = true,
        .clear_color_rgba = {0.06f, 0.07f, 0.13f, 1.0f},
    };
    ow_begin_render_pass(&pass);
    ow_end_render_pass();
}
