<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
public function up()
{
    Schema::create('oefeningen', function (Blueprint $table) {
        $table->id();
        $table->string('naam', 191);
        $table->text('beschrijving_nl');
        $table->text('beschrijving_en')->nullable();
        $table->string('afbeelding_url', 191)->nullable();
        $table->timestamps();
    });
}



    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('oefeningen');
    }
};
