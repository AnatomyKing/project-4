<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('role_user', function (Blueprint $table) {
            // composite primary key
            $table->primary(['role_id', 'user_id']);

            // foreign keys with cascade delete
            $table->foreign('role_id')
                  ->references('id')->on('roles')
                  ->cascadeOnDelete();

            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->cascadeOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('role_user', function (Blueprint $table) {
            $table->dropForeign(['role_id']);
            $table->dropForeign(['user_id']);
            $table->dropPrimary(['role_id', 'user_id']);
            // no id column to restore
        });
    }
};
