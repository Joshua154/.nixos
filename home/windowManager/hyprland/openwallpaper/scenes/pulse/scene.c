#include <openwallpaper.h>

static float phase;
static float direction = 1.0f;

__attribute__((export_name("init"))) void init(void) {
    phase = 0.0f;
}

__attribute__((export_name("update"))) void update(float delta) {
    phase += direction * delta * 0.312f;
    if (phase > 1.0f) {
        phase = 1.0f;
        direction = -1.0f;
    } else if (phase < 0.0f) {
        phase = 0.0f;
        direction = 1.0f;
    }

    ow_render_pass_info pass = {
        .clear_color = true,
        .clear_color_rgba = {
            0.04f + phase * 0.09f,
            0.06f + phase * 0.07f,
            0.15f + phase * 0.13f,
            1.0f,
        },
    };
    ow_begin_render_pass(&pass);
    ow_end_render_pass();
}
