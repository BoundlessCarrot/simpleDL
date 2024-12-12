def direct_solution (target_string):
    return [(ord(c) - 32) / 100.0 for c in target_string]

def forward(weights) :
    return [32 + round(w * 100) & 95 for w in weights]

def loss_fn(output, target) :
    # return (sum(o - t) ** 2 for o, t in zip(output, target))
    return sum(output, target) ** 2

if __name__ == "__main__":
    target_str = "out"
    target = [ord(c) for c in target_str]
    weights_direct = direct_solution (target_str)
    output_direct = forward(weights_direct)
    loss_direct = loss_fn(output_direct, target )

    print("Direct solution weights: ", weights_direct)
    print("Forward output: ", output_direct)
    print("Loss: ", loss_direct)
