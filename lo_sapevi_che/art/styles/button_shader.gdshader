shader_type canvas_item;

uniform float top_inclination : hint_range(-0.3, 0.3) = 0.115;
uniform float left_margin : hint_range(0.0, 0.4) = 0.08;
uniform float right_margin : hint_range(0.0, 0.4) = 0.07;
uniform float smoothness : hint_range(0.001, 0.01) = 0.002;

void fragment() {
    vec2 uv = UV;
    float x = uv.x;
    float y = uv.y;

    // Definisco i 4 vertici del trapezio (base superiore più larga)
    float bottom_left_x = left_margin;    // Base inferiore ristretta
    float bottom_left_y = 1.0;

    float bottom_right_x = 1.0 - right_margin;  // Base inferiore ristretta
    float bottom_right_y = 1.0;

    float top_left_x = 0.0;              // Base superiore larga
    float top_left_y = top_inclination;  // Inclinata

    float top_right_x = 1.0;             // Base superiore larga
    float top_right_y = 0.0;

    // RETTA 1: Lato sinistro (da bottom_left a top_left)
    // y = mx + q
    float m1 = (top_left_y - bottom_left_y) / (top_left_x - bottom_left_x);
    float q1 = bottom_left_y - m1 * bottom_left_x;
    float line1_y = m1 * x + q1;
    bool right_of_line1 = x >= top_left_x * (1.0 - y) + bottom_left_x * y;  // A destra del lato sinistro

    // RETTA 2: Lato superiore (da top_left a top_right)
    float m2 = (top_right_y - top_left_y) / (top_right_x - top_left_x);
    float q2 = top_left_y - m2 * top_left_x;
    float line2_y = m2 * x + q2;
    bool below_line2 = y >= line2_y;  // Sotto il lato superiore

    // RETTA 3: Lato destro (da top_right a bottom_right)
    float m3 = (bottom_right_y - top_right_y) / (bottom_right_x - top_right_x);
    float q3 = top_right_y - m3 * top_right_x;
    float line3_y = m3 * x + q3;
    bool left_of_line3 = x <= top_right_x * (1.0 - y) + bottom_right_x * y;  // A sinistra del lato destro

    // RETTA 4: Lato inferiore (orizzontale)
    bool above_line4 = y <= 1.0;  // Sopra la base inferiore

    // Controllo se il punto è dentro tutte le 4 rette
    bool inside = right_of_line1 && below_line2 && left_of_line3 && above_line4;

    if (!inside) {
        discard;
    }



}