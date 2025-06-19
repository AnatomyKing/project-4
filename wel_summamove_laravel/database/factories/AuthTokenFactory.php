<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\AuthToken;
use App\Models\User;

class AuthTokenFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = AuthToken::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'token_hash' => fake()->randomLetter(),
            'expires_at' => fake()->dateTime(),
            'revoked' => fake()->boolean(),
        ];
    }
}
