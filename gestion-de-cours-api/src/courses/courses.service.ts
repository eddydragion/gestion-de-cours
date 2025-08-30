import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCourseDto } from './dto/create-course.dto';
import { UpdateCourseDto } from './dto/update-course.dto';
import { Course } from './entities/course.entity';

@Injectable()
export class CoursesService {
  private courses: Course[] = [
    {
      id: 1,
      name: 'NestJS Fundamentals',
      description: 'A comprehensive course on NestJS.',
      hours: 20,
    },
  ];
  private idCounter = this.courses.length;

  create(createCourseDto: CreateCourseDto): Course {
    const newCourse: Course = {
      id: ++this.idCounter,
      ...createCourseDto,
    };
    this.courses.push(newCourse);
    return newCourse;
  }

  findAll(): Course[] {
    return this.courses;
  }

  findOne(id: number): Course {
    const course = this.courses.find((course) => course.id === id);
    if (!course) {
      throw new NotFoundException(`Course with ID #${id} not found`);
    }
    return course;
  }

  update(id: number, updateCourseDto: UpdateCourseDto): Course {
    const courseIndex = this.courses.findIndex((course) => course.id === id);
    if (courseIndex === -1) {
      throw new NotFoundException(`Course with ID #${id} not found`);
    }

    const courseToUpdate = this.courses[courseIndex];
    this.courses[courseIndex] = { ...courseToUpdate, ...updateCourseDto };
    return this.courses[courseIndex];
  }

  remove(id: number): { message: string } {
    const courseIndex = this.courses.findIndex((course) => course.id === id);
    if (courseIndex === -1) {
      throw new NotFoundException(`Course with ID #${id} not found`);
    }
    this.courses.splice(courseIndex, 1);
    return { message: `Course with ID #${id} has been removed.` };
  }
}
