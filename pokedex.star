load("http.star", "http")
load("time.star", "time")
load("render.star", "render")


NUM_POKEMON = 386
POKEAPI_URL = "https://pokeapi.co/api/v2/pokemon/{}"


def main():
    id_ = int(NUM_POKEMON * random()) + 1
    pokemon_url = POKEAPI_URL.format(id_)
    pokemon = http.get(pokemon_url).json()
    name = pokemon["name"].title()
    height = str(pokemon["height"] / 10) + "m"
    weight = str(pokemon["weight"] / 10) + "kg"
    sprite_url = pokemon["sprites"]["versions"]["generation-vii"]["icons"]["front_default"]
    sprite = http.get(sprite_url).body()
    return render.Root(
        child=render.Stack(
            children=[
                render.Row(
                    children=[
                        render.Box(width=32),
                        render.Box(render.Image(sprite)),
                    ]
                ),
                render.Column(
                    children=[
                        render.Text(name),
                        render.Text("# " + str(id_)),
                        render.Text(height),
                        render.Text(weight),
                    ]
                ),
            ]
        )
    )


def random():
    """Return a pseudo-random number in [0, 1)"""
    return time.now().nanosecond / 1000000000
