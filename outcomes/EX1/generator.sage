class Generator(BaseGenerator):
    def data(self):
        # Initialize a dictionary to hold ALL generated parameters and answers
        data_dict = {}

        # 1. Define symbolic variables (must be done once, early)
        # CORRECTED: Use tuple unpacking (x,) to safely get the single variable
        try:
            (x,) = CheckIt.vars('x') 
        except NameError:
            x = SR.var('x') 

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
        
        # Define expressions for numerator and denominator
        num_expr = Integer(b) * x - Integer(c)
        den_expr = x - Integer(a)
        
        # Define the function for internal use (if needed later), but rely on string building for LaTeX output
        f_x = num_expr / den_expr
        
        # *** START: Force Display-Style Fraction via string building ***
        # 1. Convert numerator and denominator to LaTeX strings.
        num_latex = latex(num_expr)
        den_latex = latex(den_expr)
        
        # 2. Manually construct the string using \dfrac{...}{...}
        f_x_latex = f"f(x) = \\dfrac{{{num_latex}}}{{{den_latex}}}"
        # *** END: Force Display-Style Fraction ***

        # Store results for Part A
        data_dict.update({
            "a": a, "b": b, "c": c,
            "f_x_latex": f_x_latex, # This variable now holds the manually constructed \dfrac string
            "f_eval_str": f"f({a})",
            "answer_A": "Undefined",
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
        })
        
        return data_dict