<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Exercise;
use App\Models\ExerciseQrCode;

class ExerciseQrCodeFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ExerciseQrCode::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'exercise_id' => Exercise::factory(),
            'qr_value' => fake()->text(),
            'created_at' => fake()->dateTime(),
        ];
    }
}
