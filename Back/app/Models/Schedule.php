<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = ['date', 'teacher_id', 'group_id', 'class_id', 'lesson_id', 'pair_number'];
}
