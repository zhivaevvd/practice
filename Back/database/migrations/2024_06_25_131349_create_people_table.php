<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('people', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('auth_id')->nullable();
            $table->string('name')->nullable();
            $table->string('surname')->nullable();
            $table->string('type')->nullable();
            $table->text('avatar_url')->nullable();
            $table->bigInteger('group_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('people');
    }
};
