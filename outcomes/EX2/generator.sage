class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        a,b = sample(range(1,10),2)
        a = choice([-1,1])*a
        b = choice([-1,1])*b
        p = randrange(2,6)

        return {
            "sum": (a*x^p).add(b*x^p,hold=True),
            "result": (a+b)*x^p,
        }
