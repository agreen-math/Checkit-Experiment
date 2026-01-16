from sage.all import *

class Generator(BaseGenerator):
    def data(self):
        # Define fixed point values (Update these later if needed)
        POINTS_A = 5
        POINTS_B = 8
        POINTS_C = 6

        # Initialize a dictionary to hold ALL generated parameters and answers
        data_dict = {}

        # 1. Define symbolic variables
        x = var('x') 
        data_dict['x'] = x
        
        # Define ranges for parameters
        range_a = list(range(-9, 0)) + list(range(1, 10))
        range_b = list(range(2, 10))
        range_c = list(range(-9, 0)) + list(range(1, 10))
        range_bd = list(range(-9, 0)) + list(range(1, 10))
        
        # =================================================================
        # 2. --- Part A: Rational Function (Undefined at x=a) ---
        # =================================================================
        
        a = choice(range_a)
        b = choice(range_b)
        c = choice(range_c)
        while c == b * a:
            c = choice(range_c)
        
        f_x = (Integer(b) * x - Integer(c)) / (x - Integer(a))
        
        # Force Display-Style Fraction via string building
        num_latex = latex(Integer(b) * x - Integer(c))
        den_latex = latex(x - Integer(a))
        f_x_latex = f"f(x) = \\dfrac{{{num_latex}}}{{{den_latex}}}"
        
        # Store results for Part A
        data_dict.update({
            "a": a, "b": b, "c": c,
            "f_x_latex": f_x_latex, 
            "f_eval_str": f"f({a})",
            "answer_A": r"\text{Undefined}",
            "points_A": POINTS_A,
        })

        # =================================================================
        # 3. --- Part B: Evaluate g(-x) for g(x) = sqrt(ax^2 + dx + b) ---
        # =================================================================
        
        a_g = choice(list(range(2, 10))) 
        b_g = choice(range_bd)
        
        d_g = 0
        if choice([True, False]):
            d_g = choice(range_bd)
        
        arg_g = Integer(a_g) * x^2 + Integer(d_g) * x + Integer(b_g)
        g_x = sqrt(arg_g)
        
        g_neg_x_expr = g_x.substitute(x = -x)
        
        # Store results for Part B
        data_dict.update({
            "a_g": a_g, "b_g": b_g, "d_g": d_g,
            "g_x_latex": f"g(x) = {latex(g_x)}",
            "answer_B": latex(g_neg_x_expr),
            "points_B": POINTS_B,
        })
        
        # =================================================================
        # 4. --- Part C: Evaluate h(boundary) for a piecewise function ---
        # =================================================================
        
        range_c_pos = list(range(1, 6))
        range_c4 = list(range(-5, 0)) + list(range(1, 6))
        range_a_h = list(range(-5, 0))
        range_b_h = list(range(1, 6))
        
        a_h = choice(range_a_h)
        b_h = choice(range_b_h)
        c1 = choice(list(range(2, 6)))
        c2 = choice(range_c_pos)
        c3 = choice(range_c_pos)
        c4 = choice(range_c4)
        
        E1 = Integer(c1) * x - Integer(c2)
        E2 = Integer(c3) 
        E3 = x^2 + Integer(c4)
        
        eval_type = choice(['A', 'B'])
        
        if eval_type == 'A':
            eval_point_h = a_h
            answer_C_value = E2
        else:
            eval_point_h = b_h
            answer_C_value = E3.substitute(x = Integer(eval_point_h))

        h_x_latex = f"h(x) = \\begin{{cases}} {latex(E1)} & \\text{{if }} x < {a_h} \\\\ {latex(E2)} & \\text{{if }} {a_h} \\leq x < {b_h} \\\\ {latex(E3)} & \\text{{if }} x \\geq {b_h} \\end{{cases}}"
        
        answer_C = latex(answer_C_value)
        
        # Store results for Part C
        data_dict.update({
            "a_h": a_h, "b_h": b_h, "c1": c1, "c2": c2, "c3": c3, "c4": c4,
            "h_x_latex": h_x_latex,
            "eval_point_h": eval_point_h,
            "answer_C": answer_C,
            "points_C": POINTS_C,
        })
        
        return data_dict