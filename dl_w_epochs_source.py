import random

# let's fuck around!
weights = [random.uniform(-1, 1) for _ in range (3)]

# "out" (ground truth we want to find)
target = [ord(c) for c in "out"] # ASCII values of 'o', 'u', 't'

# rate of fucking around
learning_rate = 0.1

def loss_fn(output, target) :
    return sum((o - t) ** 2 for o, t in zip(output, target))

def forward(weights):
    # Map to printable ASCII: [32, 126]
    return [32 + round(w * 100) % 95 for w in weights]

def backward(weights, output, target):
    # Internalizing a more proficient fuck-around strategy
    gradients = [(o - t) / 100 for o, t in zip(output, target)]
    return [w - learning_rate * g for w, g in zip(weights, gradients)]

for epoch in range(1000):
    output = forward(weights)
    loss = loss_fn(output, target)
    print(f" {epoch}: fucked around with {output} - loss = {loss: .2f}")

    # Check if we "found 'out'"
    if output == target:
        print(f"Found 'out'! Weights = {weights}")
        break

    weights = backward(weights, output, target)
    print("Fucked around and found 'out':", weights)
